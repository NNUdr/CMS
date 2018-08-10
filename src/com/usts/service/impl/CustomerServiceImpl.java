package com.usts.service.impl;

import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;

import org.springframework.stereotype.Service;

import com.usts.dao.CustomerDao;
import com.usts.entity.AccountStatement;
import com.usts.entity.Customer;
import com.usts.entity.CustomerGc;
import com.usts.service.CustomerService;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;

@Service("customerService")
public class CustomerServiceImpl implements CustomerService {

	@Resource
	private CustomerDao customerDao;
	@Override
	public List<Customer> find(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return customerDao.find(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return customerDao.getTotal(map);
	}

	@Override
	public int add(Customer customer) {
		// TODO Auto-generated method stub
		return customerDao.add(customer);
	}

	@Override
	public int update(Customer customer) {
		// TODO Auto-generated method stub
		return customerDao.update(customer);
	}

	@Override
	public int delete(Integer id) {
		// TODO Auto-generated method stub
		return customerDao.delete(id);
	}

	@Override
	public Customer findById(Integer id) {
		// TODO Auto-generated method stub
		return customerDao.findById(id);
	}

	@Override
	public List<AccountStatement> findCustomerGx(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return customerDao.findCustomerGx(map);
	}

	@Override
	public Long getTotalCost(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return customerDao.getTotalCost(map);
	}

	@Override
	public List<CustomerGc> findCustomerGc() {
		// TODO Auto-generated method stub
		return customerDao.findCustomerGc();
	}

	@Override
	public void export(String[] titles, ServletOutputStream out) {
		// TODO Auto-generated method stub
		  try{
	            // 第一步，创建一个workbook，对应一个Excel文件
	            HSSFWorkbook workbook = new HSSFWorkbook();
	            // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
	            HSSFSheet hssfSheet = workbook.createSheet("sheet1");
	            // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
	            HSSFRow hssfRow = hssfSheet.createRow(0);
	            // 第四步，创建单元格，并设置值表头 设置表头居中
	            HSSFCellStyle hssfCellStyle = workbook.createCellStyle();
	            //居中样式
	            hssfCellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

	            HSSFCell hssfCell = null;
	            for (int i = 0; i < titles.length; i++) {
	                hssfCell = hssfRow.createCell(i);//列索引从0开始
	                hssfCell.setCellValue(titles[i]);//列名1
	                hssfCell.setCellStyle(hssfCellStyle);//列居中显示                
	            }
	            
	            // 第五步，写入实体数据 
	            List<AccountStatement> accountStatements = customerDao.findCustomerGx(null);            

	            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	            if(accountStatements != null && !accountStatements.isEmpty()){
	                for (int i = 0; i < accountStatements.size(); i++) {
	                    hssfRow = hssfSheet.createRow(i+1);                
	                    AccountStatement accountStatement = accountStatements.get(i);
	                    
	                    // 第六步，创建单元格，并设置值
	                    String cName = "";
	                    if(accountStatement.getName() != null){
	                    	cName = accountStatement.getName();
	                    }
	                    hssfRow.createCell(0).setCellValue(cName);
	                    double total = 0;
	                    if(accountStatement.getTotalCost()!= 0){
	                    	total = accountStatement.getTotalCost();
	                    }
	                    hssfRow.createCell(1).setCellValue(total);
	                    
	                }
	            }
	            
	         // 第七步，将文件存到指定位置
	            try {
	            	UUID u = UUID.randomUUID();
	            	String [] uuid = u.toString().split("-");
	              //  FileOutputStream fileOutputStream = new FileOutputStream("C:/Users/79224/Desktop/"+uuid[0]+"客户消费报表.xls");//指定路径与名字和格式
		     FileOutputStream fileOutputStream = new FileOutputStream("C:/Users/79224/Desktop/"+uuid[0]+"客户消费报表"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+".xls");//指定路径与名字和格式
	            	workbook.write(fileOutputStream);//将数据写出去
	                fileOutputStream.close();//关闭输出流
	            } finally {
					//
				}
		  }catch (Exception e) {
	                e.printStackTrace();
	            }
	
		  }

	@Override
	public void exportCustomerExcel(String[] titles, ServletOutputStream out) {
		// TODO Auto-generated method stub
		  try{
	            // 第一步，创建一个workbook，对应一个Excel文件
	            HSSFWorkbook workbook = new HSSFWorkbook();
	            // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
	            HSSFSheet hssfSheet = workbook.createSheet("sheet1");
	            // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
	            HSSFRow hssfRow = hssfSheet.createRow(0);
	            // 第四步，创建单元格，并设置值表头 设置表头居中
	            HSSFCellStyle hssfCellStyle = workbook.createCellStyle();
	            //居中样式
	            hssfCellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

	            HSSFCell hssfCell = null;
	            for (int i = 0; i < titles.length; i++) {
	                hssfCell = hssfRow.createCell(i);//列索引从0开始
	                hssfCell.setCellValue(titles[i]);//列名1
	                hssfCell.setCellStyle(hssfCellStyle);//列居中显示                
	            }
	            
	            // 第五步，写入实体数据 
	            List<Customer> customers = customerDao.find(null);            

	            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	            if(customers != null && !customers.isEmpty()){
	                for (int i = 0; i < customers.size(); i++) {
	                    hssfRow = hssfSheet.createRow(i+1);                
	                    Customer customer = customers.get(i);
	                    
	                    // 第六步，创建单元格，并设置值
	                    String khno = "";
	                    if(customer.getKhno() != null){
	                    	khno = customer.getKhno();
	                    }
	                    hssfRow.createCell(0).setCellValue(khno);
	                    String name = "";
	                    if(customer.getName() != null){
	                    	name = customer.getName();
	                    }
	                    hssfRow.createCell(1).setCellValue(name);
	                    String area = "";
	                    if(customer.getArea() != null){
	                    	area = customer.getArea();
	                    }
	                    hssfRow.createCell(2).setCellValue(area);
	                    String cusManager = "";
	                    if(customer.getCusManager()!= null){
	                    	cusManager = customer.getCusManager();
	                    }
	                    hssfRow.createCell(3).setCellValue(cusManager);
	                    String level = "";
	                    if(customer.getLevel()!= null){
	                    	level = customer.getLevel();
	                    }
	                    hssfRow.createCell(4).setCellValue(level);
	                    String xyd = "";
	                    if(customer.getXyd()!= null){
	                    	xyd = customer.getXyd();
	                    }
	                    hssfRow.createCell(5).setCellValue(xyd);
	                    String address = "";
	                    if(customer.getAddress()!= null){
	                    	address = customer.getAddress();
	                    }
	                    hssfRow.createCell(6).setCellValue(address);
	                    String postCode = "";
	                    if(customer.getPostCode()!= null){
	                    	postCode = customer.getPostCode();
	                    }
	                    hssfRow.createCell(7).setCellValue(postCode);
	                    String phone = "";
	                    if(customer.getPhone()!= null){
	                    	phone = customer.getPhone();
	                    }
	                    hssfRow.createCell(8).setCellValue(phone);
	                    String khzh = "";
	                    if(customer.getKhzh()!= null){
	                    	khzh = customer.getKhzh();
	                    }
	                    hssfRow.createCell(9).setCellValue(khzh);
	                }
	            }
	            
	         // 第七步，将文件存到指定位置
	            try {
	            	UUID u = UUID.randomUUID();
	            	String [] uuid = u.toString().split("-");
	              //  FileOutputStream fileOutputStream = new FileOutputStream("C:/Users/79224/Desktop/"+uuid[0]+"客户消费报表.xls");//指定路径与名字和格式
		     FileOutputStream fileOutputStream = new FileOutputStream("C:/Users/79224/Desktop/"+uuid[0]+"客户信息报表"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+".xls");//指定路径与名字和格式
	            	workbook.write(fileOutputStream);//将数据写出去
	                fileOutputStream.close();//关闭输出流
	            } finally {
					//
				}
		  }catch (Exception e) {
	                e.printStackTrace();
	            }
	}
	}

