using System;
					
public class Program
{
	public static void Main()
	{
		for(int i= 1 ; i<=100 ; i++){
		string whizBang = "";
			if(i%2 == 0)
			{
				whizBang = String.Concat(whizBang,"Whiz");
			}
			if(i%3 == 0)
			{
				whizBang = String.Concat(whizBang,"Bang");
			}

			Console.WriteLine(String.Concat(i.ToString(),whizBang));
			
		
		}
		
	}
}