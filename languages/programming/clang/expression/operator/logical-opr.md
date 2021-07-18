# 逻辑运算符（Logical Operators）

| Operator | Name                | Syntax   | Meaning                                                     |
| -------- | ------------------- | -------- | ----------------------------------------------------------- |
| `&&`     | 逻辑与（Logic AND） | `a && b` | 对连接的表达式从左往右求值，若结果为 `false` 则立即停止计算 |
| `||`     | 逻辑或（Logic OR）  | `a || b` | 对连接的表达式从左往右求值，若结果为 `true` 则立即停止计算  |
| `!`      | 逻辑非（Logic NOT） | `!a`     |                                                             |

## a && b

| a     | b     | a && b |
| ----- | ----- | ------ |
| true  | true  | true   |
| true  | false | false  |
| false | true  | false  |
| false | false | false  |

## a || b

| a     | b     | a \|\| b |
| ----- | ----- | -------- |
| true  | true  | true     |
| true  | false | true     |
| false | true  | true     |
| false | false | false    |

## !a

| a     | !a    |
| ----- | ----- |
| true  | false |
| false | true  |
