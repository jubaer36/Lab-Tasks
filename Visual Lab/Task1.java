import java.util.Random;
import java.util.Scanner;
public class Task1{
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        int guess;
        
        Random rand = new Random();
        int rolled = rand.nextInt(6);
        System.out.println("I have rolled a dice. ");
        System.out.print("Your guess: ");
        guess = sc.nextInt();
        if (guess == rolled) {
            System.out.println("Correct!");
        }
        else{
            System.out.println("Wrong! Correct Answer is " + rolled);
        }
        // System.out.println(rand.nextInt(6));
        sc.close();

    }
}