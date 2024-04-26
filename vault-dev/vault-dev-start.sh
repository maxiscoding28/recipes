vault server -dev > output.log 2>&1

vault server -dev-three-node -dev-root-token-id=max > output.log 2>&1

vault server -dev-four-cluster

vault server -dev -dev-four-cluster 2>&1 | tee \
 >(grep "perf-pri" | grep "core0" > perf-pri-core0.log) \
 >(grep "perf-pri" | grep "core1" > perf-pri-core1.log) \
 >(grep "perf-pri" | grep "core2" > perf-pri-core2.log) \
 >(grep "perf-pri" | grep "core3" > perf-pri-core3.log) \
 >(grep "perf-sec" | grep "core0" > perf-sec-core0.log) \
 >(grep "perf-sec" | grep "core1" > perf-sec-core1.log) \
 >(grep "perf-sec" | grep "core2" > perf-sec-core2.log) \
 >(grep "perf-sec" | grep "core3" > perf-sec-core3.log) \
 >(grep "perf-pri-dr" | grep "core0" > perf-pri-dr-core0.log) \
 >(grep "perf-pri-dr" | grep "core1" > perf-pri-dr-core1.log) \
 >(grep "perf-pri-dr" | grep "core2" > perf-pri-dr-core2.log) \
 >(grep "perf-pri-dr" | grep "core3" > perf-pri-dr-core3.log) \
 >(grep "perf-sec-dr" | grep "core0" > perf-sec-dr-core0.log) \
 >(grep "perf-sec-dr" | grep "core1" > perf-sec-dr-core1.log) \
 >(grep "perf-sec-dr" | grep "core2" > perf-sec-dr-core2.log) \
 >(grep "perf-sec-dr" | grep "core3" > perf-sec-dr-core3.log)