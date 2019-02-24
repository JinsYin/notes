# 序列号

## json

```python
import json

print(json.loads('{"name": "John", "age": 18}')) # √
print(json.loads("{'name': 'John', 'age': 18}")) # × JSONDecodeError
```