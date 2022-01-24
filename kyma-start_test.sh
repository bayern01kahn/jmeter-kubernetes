#!/usr/bin/env bash
#Script created to launch Jmeter tests directly from the current terminal without accessing the jmeter master pod.
#It requires that you supply the path to the jmx file
#After execution, test script jmx file may be deleted from the pod itself but not locally.

working_dir="`pwd`"

#Get namesapce variable
tenant=`awk '{print $NF}' "$working_dir/tenant_export"`

jmx="$1"
[ -n "$jmx" ] || read -p 'Enter path to the jmx file ' jmx

if [ ! -f "$jmx" ];
then
    echo "Test script file was not found in PATH"
    echo "Kindly check and input the correct file path"
    exit
fi

test_name="$(basename "$jmx")"

#Get Master pod details

master_pod=`kubectl get po -n $tenant | grep jmeter-master | awk '{print $1}'`

echo "kcp starting"
echo "jmx=$jmx"
echo "test_name=$test_name"
echo "copy to $master_pod:/$test_name"

kubectl cp $jmx -n $tenant $master_pod:/$test_name -c jmmaster 

echo "kcp done"
## Echo Starting Jmeter load test

kubectl exec -ti -n $tenant $master_pod -c jmmaster -- /bin/bash /load_test "$test_name"
# kubectl exec -ti -n perf jmeter-master-7d5b655c7f-wpvxd -c jmmaster -- /bin/bash /load_test s
