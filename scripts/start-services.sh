cat > scripts/start-services.sh << 'EOF'
#!/bin/bash
if [ "$NODE_TYPE" = "master" ]; then
    hdfs namenode -format -force
    start-dfs.sh
    start-yarn.sh
fi

if [ "$NODE_TYPE" = "worker" ]; then
    hdfs datanode &
    yarn nodemanager &
fi

tail -f /dev/null
EOF