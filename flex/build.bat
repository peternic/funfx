IF NOT EXIST "%FLEX_SDK_HOME%" SET FLEX_SDK_HOME=C:\Program Files\Adobe\Flex Builder 3 Plug-in\sdks\3.0.0
"%FLEX_SDK_HOME%\bin\compc" -verbose-stacktraces -source-path+=src -output ../gem/ext/FunFX.swc -include-classes AQAdapter custom.CustomAutomationClass AQEnvironment custom.CustomAutomationEventDescriptor custom.CustomAutomationMethodDescriptor custom.CustomAutomationPropertyDescriptor custom.utilities.EnvXMLParser custom.utilities.IFlexObjectLocatorUtility custom.utilities.IFlexObjectLocatorUtilityHelper custom.utilities.FlexObjectLocatorUtility custom.utilities.FlexObjectLocatorUtilityHelper IAQCodecHelper IAQMethodDescriptor IAQPropertyDescriptor codec.ArrayPropertyCodec codec.AssetPropertyCodec codec.AutomationObjectPropertyCodec codec.ColorPropertyCodec codec.DatePropertyCodec codec.DateRangePropertyCodec codec.DateScrollDetailPropertyCodec codec.DefaultPropertyCodec codec.HitDataCodec codec.KeyCodePropertyCodec codec.KeyModifierPropertyCodec codec.ListDataObjectCodec codec.ScrollDetailPropertyCodec codec.ScrollDirectionPropertyCodec codec.TabObjectCodec codec.TriggerEventPropertyCodec funfx.Proxy funfx.model.FunFXRecordingModel funfx.model.FunFXRecordedCommand funfx.flexlocator.FlexObjectLocator funfx.recording.FunFXRecording
