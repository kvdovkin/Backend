using System;

namespace Remove_duplicates
{
    class Program
    {
        static void Main(string[] args)
        {
            if(args.Length != 1)
            {
                Console.WriteLine("Incorrect number of arguments!\nUsage remove_duplicates.exe < input string >");
            }
            else
            {
                string Duplicates = "";
                for(int i = 0; i < args[0].Length; ++i)
                {
                    if (!Duplicates.Contains(args[0][i]))
                    {
                        Duplicates = Duplicates + args[0][i];
                    }
                    else
                    {
                        continue;
                    }
                }
                Console.WriteLine(Duplicates);
            }
        }
    }
}