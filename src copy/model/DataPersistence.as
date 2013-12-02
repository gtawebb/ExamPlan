package model
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.registerClassAlias;

	public class DataPersistence
	{
		public function readData(filename:String):Object
		{
			registerClassAlias("ExamDataSet", ExamDataSet);
			registerClassAlias("Exam", Exam);

			trace("my saved object file name = "+filename);
			var file:File = File.applicationStorageDirectory.resolvePath(filename);
			var myCategories:Object;
			
			if (!file.exists)
			{	
				trace("the file doesn't exist")
				
			}
			else
			{
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.READ);
				myCategories = fileStream.readObject();
			
				fileStream.close();
			}
			return myCategories;
		}
		
		
		
		public function saveData(data:Object, filename:String):void {
			registerClassAlias("ExamDataSet", ExamDataSet);
			registerClassAlias("Exam", Exam);


			trace("saving data, filename = "+filename)
		
			
			var file:File = File.applicationStorageDirectory.resolvePath(filename);
			if (file.exists)
				file.deleteFile();
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);// and open the file for write
			fileStream.writeObject(data);//write the object to the file
			
			
			fileStream.close();
		}
	}
}