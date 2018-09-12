package polar.island.core.entity;

import polar.island.core.util.PropertieUtil;

import java.io.Serializable;

/**
 * 通用的返回数据实体类
 */
public class ResponseJson implements Serializable {
    private String code;
    private Object data;
    private String msg;
    private Long count;

    public ResponseJson(String code) {
        this(code, null, null);
    }

    public ResponseJson(String code, Object data) {
        this(code, data, null);
    }

    public ResponseJson(String code, Object data, String msg) {
        this(code, data, msg, null);
    }

    public ResponseJson(String code, Object data, String msg, Long count) {
        this.code = code;
        this.data = data;
        this.msg = msg;
        this.count = count;
        if (this.msg == null) {
            this.msg = PropertieUtil.getMsg(this.code);
        }
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }
}
