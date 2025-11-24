
import java.util.Scanner;

public class Task2 {
    public static void main(String[] args) {
        System.out.println("The number to compute factorial: ");
        Scanner sc = new Scanner(System.in);
        int n , ans = 1;
        n = sc.nextInt();
        for (int i = 1; i <= n; i++) {
            ans = i* ans;
        }
        System.out.println(ans);

    }
}
