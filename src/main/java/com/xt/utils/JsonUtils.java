package com.xt.utils;

public class JsonUtils<T> {
    private String msg;
    private T result;
    private String  errorCode;
    private String total;

    public JsonUtils(String msg, T result, String errorCode) {
        super();
        this.msg = msg;
        this.result = result;
        this.errorCode = errorCode;
    }

    @Override
    public String toString() {
        return "JsonUtils{" +
                "msg='" + msg + '\'' +
                ", result=" + result +
                ", errorCode='" + errorCode + '\'' +
                ", total='" + total + '\'' +
                '}';
    }

    public JsonUtils() {
        super();
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getResult() {
        return result;
    }

    public void setResult(T result) {
        this.result = result;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }
}
