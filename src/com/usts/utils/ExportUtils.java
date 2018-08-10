package com.usts.utils;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;

import java.io.*;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


public class ExportUtils {

    public ExportUtils() {
    }

    /**
     * 导出
     *
     * @param file 文件
     * @param headers 输出头
     * @param dataList 输出数据
     * @return 执行是否成功
     */
    public static boolean exportExcel(File file, String[] headers, List<Object[]> dataList) throws IOException {
        FileOutputStream fileOutputStream = new FileOutputStream(file);
        // 声明一个工作薄
        Workbook workbook = new HSSFWorkbook();
        // 创建一个标签页
        Sheet sheet = workbook.createSheet();

        // 字体-粗体
        Font boldFont = workbook.createFont();
        boldFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
        // 标题样式
        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerStyle.setBorderBottom(CellStyle.BORDER_THIN);
        headerStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerStyle.setFont(boldFont);

        // 内容样式
        CellStyle bodyStyle = workbook.createCellStyle();
        bodyStyle.setAlignment(CellStyle.ALIGN_CENTER);
        bodyStyle.setBorderTop(CellStyle.BORDER_THIN);
        bodyStyle.setBorderRight(CellStyle.BORDER_THIN);
        bodyStyle.setBorderBottom(CellStyle.BORDER_THIN);
        bodyStyle.setBorderLeft(CellStyle.BORDER_THIN);

        // 标题行
        Row headerRow = sheet.createRow(0);
        if (headers != null && headers.length > 0) {
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellStyle(headerStyle);
                cell.setCellValue(headers[i]);
            }
        }

        // 内容行
        if (dataList != null && dataList.size() > 0){
            for (int i=0; i<dataList.size(); i++) {
                Row row = sheet.createRow(i+1);
                Object[] data = dataList.get(i);
                if (data == null) continue;
                for (int j = 0; j < data.length; j++) {
                    Cell cell = row.createCell(j);
                    cell.setCellStyle(bodyStyle);
                    Object item = data[j];
                    if(item == null || item.equals(null)) continue;
                    if (item instanceof Number) {
                        cell.setCellValue(((Number) item).doubleValue());
                    } else if (item instanceof Boolean) {
                        cell.setCellValue((Boolean) item);
                    } else if (item instanceof Date){
                        cell.setCellValue((Date) item);
                    } else if (item instanceof Calendar) {
                        cell.setCellValue((Calendar) item);
                    } else {
                        cell.setCellValue(item.toString());
                    }
                }
            }
        }

        sheet.autoSizeColumn(1,true);

        try {
            workbook.write(fileOutputStream);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        } finally {
            fileOutputStream.close();
        }
        return true;
    }
}
