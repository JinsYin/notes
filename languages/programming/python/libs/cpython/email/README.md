# Email

## 范例

```json
{
    "server": {
        "host": "smtp.qq.com",
        "port": 25,
        "sslport": 465
    },
    "sender": {
        "username": "123456789@qq.com",
        "authcode": "abcedfghijklmn"
    },
    "receivers": [
        "example@163.com",
        "example@gmail.com"
    ]
}
```

```python
import json
import email.mime.text import MIMEText

class Mail():
    def __init__(self, path):
        self.cfg = self.__loadcfg(path)
        self.sender = cfg['sender']['username']
        self.receivers = cfg['receivers']
        self.authcode = cfg['sender']['authcode'] # 授权码
        self.host = cfg['server']['host']
        self.sslport = cfg['server']['sslport']

    def __loadcfg(self, path):
        ret = {}
        try:
            with open(path, 'r') as f:
                ret = json.loads(path)
                f.close()
        except OSError as e:
            logging.info('[系统异常] {}'.format(e))
        return ret

    def send(self):
        pass

    def sendtext(self, text, subtype='plain'):
        '''发送文本
        '''
        try:
            message = MIMEText(text, subtype, 'utf-8')
            message['Subject'] = '抢单成功'
            message['From'] = '{}'.format(sender)
            message['To'] = '{}'.join(receivers)

            server = smtplib.SMTP_SSL(self.host, self.sslport)
            server.login(username, authcode)
            result = cxt.sendmail(self.sender, self.receivers, message.as_string())
            if result == {}:
                logging.info('[邮件发送成功]')
            server.quit()
        except smtplib.SMTPException as e:
            logging.info('[SMTP异常] {}'.format(e))

    def sendimage(self):
        '''发送图片
        '''
        pass
```
