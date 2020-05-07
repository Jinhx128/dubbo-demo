package com.jinhaoxun.dubbo.module.rocketmq.model.request;

import com.jinhaoxun.dubbo.model.service.ServiceRequest;
import lombok.Getter;
import lombok.Setter;

/**
 * @version 1.0
 * @author jinhaoxun
 * @date 2018-05-09
 * @description 发送RocketMQ消息请求实体类
 */
@Setter
@Getter
public class AddMessageServiceReq extends ServiceRequest {

    private String topic;

    private String tag;

    private String message;

}
