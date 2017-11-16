/*
*Created by liulei on 2016/4/25.
*/
package com.model;

import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by liulei on 2016/4/25.
 */
public class ComboTree {

    public String id;
    public String text;
    public String parentId;
    public List<ComboTree> children;

    public ComboTree() {
        id = "";
        text = "";
        parentId = "";
        children = new ArrayList<>();
    }

    public ComboTree(String id, String text) {
        this.id = id;
        this.text = text;
    }

    public ComboTree(String id, String text, String parentId) {
        this.id = id;
        this.text = text;
        this.parentId = parentId;
    }

    public ComboTree(String id, String text, List<ComboTree> children) {
        this.id = id;
        this.text = text;
        this.children = children;
    }

    public ComboTree(String id, String text, String parentId, List<ComboTree> children) {
        this.id = id;
        this.text = text;
        this.parentId = parentId;
        this.children = children;
    }

    public String getId() {
        return id;
    }

    public String getText() {
        return text;
    }

    public String getParentId() {
        return parentId;
    }

    public List<ComboTree> getchildren() {
        return children;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setText(String text) {
        this.text = text;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public void setchildren(List<ComboTree> children) {
        this.children = children;
    }

    @Override
    public String toString() {
        return "ComboTree{" +
                "id='" + id + '\'' +
                ", text='" + text + '\'' +
                ", parentId='" + parentId + '\'' +
                ", children=" + children +
                '}';
    }
}
