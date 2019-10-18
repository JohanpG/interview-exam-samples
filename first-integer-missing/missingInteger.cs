using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

namespace Rextester
{

    public class Program
    {
        public static int solution(int[] A) {
            // Get only positive values
            A= Array.FindAll(A,x=> x>0);
            int minValue = 1;
           
            if(A!= null || A.Count()>0)
            {
                // sort array
                Array.Sort(A);
                //Console.WriteLine("----------");
                //Array.ForEach(A,u => Console.WriteLine(u.ToString()));
                //Console.WriteLine("----------");
                //Create variables to hold found minimun integer value missing
                bool found = false;
                int lastMax = 0;
                //Divide the array in groups on 10s
                int numberOfGroups = Convert.ToInt32(A.Count()/10) ;
                numberOfGroups = numberOfGroups > 0? numberOfGroups: 1;
               
                Console.Write("Groups:");
                Console.WriteLine(numberOfGroups);
                //Iterate each group
                for(int i= 1 ;i<=numberOfGroups ; i++)
                {
                    if(found)
                    {
                        continue;
                    }

                    //Subset the array
                    var subArray = A.Skip(10*(i-1)).Take(10*i).ToArray();
                    //Create an array and filled with integer to compare
                    List<int> toCompare = new List<int>{};
                    for(int j= (lastMax+1) ;j<=(subArray[subArray.Count()-1]) ; j++)
                    {
                        toCompare.Add(j);
                    }
                    //Update last max checked value
                    lastMax=subArray[subArray.Count()-1];
                    /*
                    Console.WriteLine("----------");
                    toCompare.ForEach(k => Console.WriteLine(k.ToString()));
                    Console.WriteLine("----------");
                    */
                    //Create variable to hold tested values
                    List<int> tested = new List<int>{};
                    foreach(int n in subArray)
                    {
                        tested.Add(n);
                        if(toCompare.Any(x=> x<n && !tested.Contains(x)) )
                        {
                            minValue = toCompare.FirstOrDefault((x=> x<n && !tested.Contains(x)));
                            found=true;
                            Console.WriteLine(minValue);
                            break;

                        }
                    }


                }
                //If not found the is one more that the last
                if(!found)
                {
                    minValue=lastMax+1;
                }
            }

             return minValue;

        } 
        public static void Main(string[] args)
        {
            //Your code goes here
            Console.WriteLine("Hello, world!");
            List<int> arr = new List<int>{};
            for(int j=1 ;j<=99999 ; j++)
            {
                arr.Add(j);
            }
            // int[] arr = new int[] {-1,-45,-2334,1,2,3,4,5};
            Console.Write("Result");
            Console.WriteLine(solution(arr.ToArray()));
           

        }
    }
}
