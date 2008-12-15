#!/bin/sh
FLEX_SDK_HOME="/Applications/Adobe Flex Builder 3/sdks/3.0.0"
"$FLEX_SDK_HOME/bin/mxmlc" -verbose-stacktraces -include-libraries ../flex/FunFX.swc "$FLEX_SDK_HOME/frameworks/libs/automation.swc" "$FLEX_SDK_HOME/frameworks/libs/automation_dmv.swc"  "$FLEX_SDK_HOME/frameworks/libs/automation_agent.swc" -output ../gem/website/demo-app/DemoApp.swf -- src/FlexObjectTest.mxml