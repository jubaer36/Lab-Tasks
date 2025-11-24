package org.example.lab_05_2b_210041226;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;

public class Calculator {

    @FXML
    private TextField txt_result;
    String op = ""; // Initialize op to avoid null pointer exceptions
    double number1, number2; // Change data type to double
    boolean waitingForInput = false;

    public void Number(ActionEvent ae) {
        String no = ((Button) ae.getSource()).getText();
        if(op.equals("=")){
            txt_result.setText("");
            op =  "";
        }
        txt_result.setText(txt_result.getText() + no);
        waitingForInput = false;
    }

    public void Operation(ActionEvent ae) {
        String operation = ((Button) ae.getSource()).getText();

        if (operation.equals("C")) {
            txt_result.setText("");
            op = "";
            waitingForInput = false;
            return;
        }

        // Check if waiting for input
        if (waitingForInput) {
            txt_result.setText("Please input numbers first");
            return;
        }

        if (!operation.equals("=")) {
            if (!op.equals("")) {
                return;
            }
            if(op.equals("=")){
                txt_result.setText("");
            }
            op = operation;
            number1 = Double.parseDouble(txt_result.getText()); // Parse as double
            txt_result.setText("");
            waitingForInput = true; // Set waiting for input after an operation is pressed
        } else {
            if (op.equals("")){
                return;
            }
            number2 = Double.parseDouble(txt_result.getText()); // Parse as double
            Calculate(op, number1, number2);
            op = "=";
            number1 = Double.parseDouble(txt_result.getText()); // Parse as double
            waitingForInput = false;
        }
    }


    public void Calculate(String op, double n1, double n2) { // Change parameters to double
        switch (op) {
            case "+":
                txt_result.setText(String.valueOf(n1 + n2));
                break;
            case "-":
                txt_result.setText(String.valueOf(n1 - n2));
                break;
            case "*":
                txt_result.setText(String.valueOf(n1 * n2));
                break;
            case "/":
                if (n2 == 0) {
                    txt_result.setText("Math Error");
                } else {
                    txt_result.setText(String.valueOf(n1 / n2));
                }
                break;
        }
    }
}
