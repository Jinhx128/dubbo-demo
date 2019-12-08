package com.jinhaoxun.dubbo.model.web;


import com.jinhaoxun.dubbo.model.base.Model;

import java.util.Date;

/**
 * @Description: Http的响应大对象
 * @author humeng
 * @date 2018年12月29日 下午8:15:39
 */
public class HttpResponse<T> extends Model {
	/**
	 * 响应码
	 */
	private String code;
	/**
	 * 响应时间
	 */
	private Date time;
	/**
	 * 响应的信息（一般为错误信息）
	 */
	private String msg;
	/**
	 * 响应数据（一般为ActionResponse的子类）
	 */
	private T data;
	/**
	 * 响应的密文，如果该接口需要加密返回，
	 * 则将data的密文绑定到该字段上，
	 * srs和data至少有一个为空
	 */
	private String srs;
	
	/**
	 * 私有化默认构造器
	 */
	private HttpResponse() {
	}
	
	private HttpResponse(String code, String msg, T data) {
		this.code = code;
		this.msg = msg;
		this.data = data;
		this.time = new Date();
	}
	/**
	* @Description: 构建一个响应
	* @author humeng  
	* @date 2019年1月2日 下午2:09:24 
	* @param code
	* @param msg
	* @param data
	* @return
	 */
	public static <T> HttpResponse<T> build(String code, String msg, T data){
		return new HttpResponse<T>(code, msg, data);
	}
	/**
	* @Description: 构建一个成功带数据和msg的响应
	* @author humeng  
	* @date 2019年1月2日 下午2:08:52 
	* @param msg
	* @param data
	* @return
	 */
	public static <T> HttpResponse<T> build(String msg, T data){
//		return build(ResultCode.SUCCESS, msg, data);
		return null;
	}
	/**
	* @Description: 构建一个成功带响应数据的响应（不带msg）
	* @author humeng  
	* @date 2019年1月2日 下午2:07:35 
	* @param data
	* @return
	 */
	public static <T > HttpResponse<T> build(T data)
	{
		return build(null, data);
	}
	/**
	* @Description: 构建一个空的默认的成功响应
	* @author humeng  
	* @date 2019年1月2日 下午2:07:11 
	* @return
	 */
	public static <T> HttpResponse<T> build(){
		return build(null);
	}

	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public T getData() {
		return data;
	}
	public void setData(T data) {
		this.data = data;
	}
	public String getSrs() {
		return srs;
	}
	public void setSrs(String srs) {
		this.srs = srs;
	}
}
