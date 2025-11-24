#include<iostream>
#include<string>
using namespace std;

class Flight{
private:
    int flightNumber;
    string destination;
    float distance;
    float maxFuelCapacity;
    float fuelRequired;
public:

    float get_fuelRequired(){
        if(distance<=1000)return 500;
        if(distance<=2000)return 1100;
        else return 2200;

    }
    void show_info(){
        cout << "Flight number: " <<flightNumber << endl;
        cout << "Destination: "<< destination << endl;
        cout << "Distance: " << distance << endl;
        cout << "Max Fuel Capacity: " << maxFuelCapacity << endl;
        cout << "Fuel Required: "<< get_fuelRequired() << endl;
    }
    Flight(int flightNumber = 0 , string destination = "" , float distance = 0.0 , float maxFuelCapacity = 0.0){
        this->flightNumber = flightNumber;
        this->destination = destination;
        this->distance = distance;
        this->maxFuelCapacity = maxFuelCapacity;
    }
    ~Flight(){
        cout<<this->flightNumber  << "  Object is destructed" << endl;
    }
};

int main(){
    Flight Plane1(1,"Bangkok",1343.4,1200);
    Plane1.show_info();
}
