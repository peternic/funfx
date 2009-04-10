package funfx.model
{
  public class FunFXRecordingModel
  {
    public function FunFXRecordingModel(){
    }
    
    public function getArgsFromString(str:String):String{
			  var temp:String = str.replace(/@\w+\.\w+\({.+}\)\.([a-zA-Z_]+)\((.+)\)/,'$2');
			  temp = temp.replace(/'|\s/g,'');
			  var array:Array = temp.split(',');
			  return array.join("_ARG_SEP_");
		  }
		
		  public function getEventFromString(str:String):String{
			  var temp:String = str.replace(/@\w+\.\w+\({.+}\)\.([a-zA-Z_]+)\((.+)\)/,'$1');
			  temp = temp.replace(/'|\s/g,'');
			  return temp;
		  }
		
		  public function getIdFromString(str:String):String{
			  str = str.replace(/@?\w+.\w+\(?({:.+})\).+/,'$1');
			  str = str.replace(/({[a-zA-Z0-9=>:' ,]+}).?/, "$1|");
			  var array:Array = str.split('|');
			  var result:String = "";
			  for(var i:int=0; i<array.length; i++){
				  result += convertInner(array[i]);
				  if(i<(array.length-2)) result += '|';
			  }
			  return result;
		  }
		
		  protected function convertInner(str:String):String{
			  var result:String = "";
			  str = str.replace(/\s/g,'')
			  str = str.substr(1, str.length-2);
			  var array:Array = str.split(',');
			  for(var i:int=0; i<array.length; i++){			
				  result += array[i].replace(/:([a-zA-Z0-9_-]+)=>.([:a-zA-Z0-9_-]+)./, "$1{$2 string}");
			  }
			  return result;
		  }
  }
}

