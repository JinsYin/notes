#define max(x, y) (x > y ? x : y) // 参数无类型
#define min(x, y) (x < y ? x : y)

/**
 * 乘方（指数运算）：计算整数 a 的 x 次幂
 */
int power(int a, int x)
{
    int result; // 计算结果

    // x > 0 时
    for (result = 1; x > 0; x--)
        result = result * a;

    return result;
}

/**
 * 开方：求平方根（square root）
 */
int sqrt()
{
}

/**
 * 阶乘
 */
int factorial()
{
}

/*
 * 绝对值（absolute value）
 */
int abs()
{
}