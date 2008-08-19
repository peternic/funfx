#!/bin/sh
FLEX_SDK_HOME="/Applications/Adobe Flex Builder 3/sdks/3.0.0"
"$FLEX_SDK_HOME/bin/mxmlc" -include-libraries ../gem/ext/FunFX.swc -output lib/DemoApp.swf -- src/FlexObjectTest.mxml