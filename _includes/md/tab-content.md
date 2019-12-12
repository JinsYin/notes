<ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" data-target="#x86_64_repo">x86_64 / amd64</a></li>
    <li><a data-toggle="tab" data-target="#armhf_repo">armhf</a></li>
    <li><a data-toggle="tab" data-target="#arm64_repo">arm64</a></li>
    <li><a data-toggle="tab" data-target="#ppc64le_repo">ppc64le (IBM Power)</a></li>
    <li><a data-toggle="tab" data-target="#s390x_repo">s390x (IBM Z)</a></li>
</ul>
<div class="tab-content">
<div id="x86_64_repo" class="tab-pane fade in active" markdown="1">

```bash
$ sudo add-apt-repository \
    "deb [arch=amd64] {{ download-url-base }} \
    $(lsb_release -cs) \
    stable"
```

</div>
<div id="armhf_repo" class="tab-pane fade" markdown="1">

```bash
$ sudo add-apt-repository \
    "deb [arch=armhf] {{ download-url-base }} \
    $(lsb_release -cs) \
    stable"
```

</div>
<div id="arm64_repo" class="tab-pane fade" markdown="1">

```bash
$ sudo add-apt-repository \
    "deb [arch=arm64] {{ download-url-base }} \
    $(lsb_release -cs) \
    stable"
```

</div>
<div id="ppc64le_repo" class="tab-pane fade" markdown="1">

```bash
$ sudo add-apt-repository \
    "deb [arch=ppc64el] {{ download-url-base }} \
    $(lsb_release -cs) \
    stable"
```

</div>
<div id="s390x_repo" class="tab-pane fade" markdown="1">

```bash
$ sudo add-apt-repository \
    "deb [arch=s390x] {{ download-url-base }} \
    $(lsb_release -cs) \
    stable"
```

</div>
</div> <!-- tab-content -->
