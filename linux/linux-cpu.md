# CPU


## CPU 压测

* 通过 bc 命令计算特别函数

```bash
$ yum install -y bc

$ # 计算圆周率
$ time echo "scale=5000; 4*a(1)" | bc -l -q
```

s (x)  The sine of x, x is in radians.    正玄函数 
c (x)  The cosine of x, x is in radians.  余玄函数 
a (x)  The arctangent of x, arctangent returns radians. 反正切函数 
l (x)  The natural logarithm of x.  log函数(以2为底) 
e (x)  The exponential function of raising e to the value x.  e的指数函数 
j (n,x) The bessel function of integer order n of x.   贝塞尔函数 