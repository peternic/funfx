
SET FLEX_SDK_HOME=C:\Program Files\Adobe\Flex Builder 3 Plug-in\sdks\3.1.0
"%FLEX_SDK_HOME%\bin\mxmlc" -include-libraries "%FLEX_SDK_HOME%\frameworks\libs\automation.swc" "%FLEX_SDK_HOME%\frameworks\libs\automation_agent.swc" -output lib\DemoApp.swf -- src\FlexObjectTest.mxml