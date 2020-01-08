package com.jinhaoxun.dubbo.model.base;

import com.alibaba.fastjson.JSON;

import java.io.Serializable;

/**
* @Description: 模型层,POJO对象具备转JSON字符串
* @author humeng  
* @date 2018年12月29日 下午8:39:23
 */
public class Model implements Serializable {

	private static final long serialVersionUID = 1L;

	@Override
	public String toString() {
		try {
			return JSON.toJSONString(this);
		}catch (Exception e) {
			e.printStackTrace();
			return super.toString();
		}
	}
}
