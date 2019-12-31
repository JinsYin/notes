{% assign d4a_stable = "CE-Stable-1" %}
{% assign d4a_edge = "CE-Edge-1" %}
{% assign d4a_test = "CE-Test-1" %}

{% capture aws_blue_latest %}
<a class="button outline-btn aws-deploy" href="https://console.aws.amazon.com/cloudformation/home#/stacks/new?stackName=Docker&templateURL=https://editions-us-east-1.s3.amazonaws.com/aws/stable/Docker.tmpl" data-rel="{{ d4a_stable }}" target="blank">Deploy Docker Community Edition (CE) for AWS (stable)</a>
{% endcapture %}

{% capture aws_blue_vpc_latest %}
<a class="button outline-btn min-hgt aws-deploy" href="https://console.aws.amazon.com/cloudformation/home#/stacks/new?stackName=Docker&templateURL=https://editions-us-east-1.s3.amazonaws.com/aws/stable/Docker-no-vpc.tmpl" data-rel="{{ d4a_stable }}" target="blank">Deploy Docker Community Edition (CE) for AWS (stable)<br/><small>uses your existing VPC</small></a>
{% endcapture %}
