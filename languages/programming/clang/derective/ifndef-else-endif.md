# ifndef-end-endif

`#ifndef` 和 `#endif` 成对出现。

## 语法

```c
#ifndef <macro_definition> //  if not defined
...
#endif
```

```c
#ifndef <token>
/* code */
#else
/* code to include if the token is defined */
#endif
```

## 用法

```c
/*
 * header_file.h
 */
#ifndef HEADER_FILE_H
#define HEADER_FILE_H

...

#endif
```

* 预处理器防止头文件被包含多次
* 防止递归包含，比如： `"a.h"` 包含 `"b.h"`，而 `"b.h"` 又包含 `a.h`
