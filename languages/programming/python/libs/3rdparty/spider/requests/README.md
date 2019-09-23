# Requests

## 范例

```python
class API()
    def __init__(self):
        self.timeout = 5
        self.timeout_sleep = 60

    def get(self):
        ret = ''
        req = {
            'url': 'https://www.baidu.com',
            'method': 'GET',
            'body': ''
        }
        try:
            res = requests.get(
                url=req['url'], headers=req['headers'], data=req['body'], timeout=self.timeout)
            if res.status_code == 200:
                logging.info('[请求成功]')
                ret = res.text
            else:
                logging.info('[状态码({})异常] 系统将休息 5 分钟后重试......'
                             .format(res.status_code))
                time.sleep(300)
        except requests.exceptions.Timeout:
            logging.info('[请求超时]！系统将休息 1 分钟后重试.....')
            time.sleep(self.timeout_sleep)

        return ret
```
