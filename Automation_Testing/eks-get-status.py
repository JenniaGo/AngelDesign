import boto3

client = boto3.client('eks', region_name="eu-west-2")
# Get all eks clusters
clusters = client.list_clusters()['clusters']
for cluster in clusters:
    response = client.describe_cluster(
        name=cluster
    )
    # get cluster info
    cluster_info = response['cluster']
    cluster_status = cluster_info['status']
    cluster_endpoint = cluster_info['endpoint']
    cluster_version = cluster_info['version']
    # Get nodegroup info from cluster name
    nodes_list = client.list_nodegroups(clusterName=cluster)['nodegroups']    
    for node_group in nodes_list:
        nodes_response = client.describe_nodegroup(
            clusterName = cluster,
            nodegroupName = node_group
        )
        nodes_info = nodes_response['nodegroup']
        nodes_cluster = nodes_info['clusterName']
        node_group_name = nodes_info['nodegroupName']
        node_group_state = nodes_info['status']
        scaling_info = nodes_info['scalingConfig']['desiredSize']
        max_desired = nodes_info['scalingConfig']['maxSize']
        node_type = nodes_info['instanceTypes'][0]
        node_version = nodes_info['version']
    # cluster output
    print(f"Cluster {cluster} status is {cluster_status}")
    print(f"Cluster endpoint: {cluster_endpoint}")
    print(f"Cluster version: {cluster_version}\n")
    # nodes group output
    print(f'Nodes group {node_group_name} is {node_group_state} inside cluster: {nodes_cluster}')
    print(f'Node group desired is: {scaling_info} out of max: {max_desired}, of instance type: {node_type}')
    print(f'Node group version is: {node_version}')
