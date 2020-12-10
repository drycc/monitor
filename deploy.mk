install:
	helm upgrade monitor ../charts/monitor --install --namespace drycc --set grafana.org=${IMAGE_PREFIX},grafana.image_tag=${VERSION},telegraf.org=${IMAGE_PREFIX},telegraf.image_tag=${VERSION}


upgrade: 
	helm upgrade monitor ../charts/monitor --namespace drycc --set grafana.org=${IMAGE_PREFIX},grafana.image_tag=${VERSION},telegraf.org=${IMAGE_PREFIX},telegraf.image_tag=${VERSION}

uninstall:
	helm delete monitor