# intr_handler() - 实现中断处理程序

## 定义

```c
static irqreturn_t intr_handler(int irq, void *dev)
```

## 范例

```c
/**
 * <drivers/edac/synopsys_edac.c>
 *
 * intr_handler - Interrupt Handler for ECC interrupts.
 * @irq:        IRQ number.
 * @dev_id:     Device ID.
 *
 * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
 */
static irqreturn_t intr_handler(int irq, void *dev_id)
{
	const struct synps_platform_data *p_data;
	struct mem_ctl_info *mci = dev_id;
	struct synps_edac_priv *priv;
	int status, regval;

	priv = mci->pvt_info;
	p_data = priv->p_data;

	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
	regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
	if (!(regval & ECC_CE_UE_INTR_MASK))
		return IRQ_NONE;

	status = p_data->get_error_info(priv);
	if (status)
		return IRQ_NONE;

	priv->ce_cnt += priv->stat.ce_cnt;
	priv->ue_cnt += priv->stat.ue_cnt;
	handle_error(mci, &priv->stat);

	edac_dbg(3, "Total error count CE %d UE %d\n",
		 priv->ce_cnt, priv->ue_cnt);
	writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
	return IRQ_HANDLED;
}
```

## 示例

```c
```