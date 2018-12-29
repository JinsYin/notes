// 创建 KEYSPACE
CREATE KEYSPACE demo;

USE demo;

// 创建表
CREATE TABLE user (
  name varchar,
  age int
);

// 插入数据
INSERT INTO user(name, age) VALUES("Bob", 22);