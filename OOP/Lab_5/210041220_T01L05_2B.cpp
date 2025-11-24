#include<iostream>
#include<string>
using namespace std;
class Product{
    private:
        string name;
        int ID;
        float price;
        int quantity;
        string category;
        bool availability_status=true;
    public:
        int flag=0;
        static int totalProducts;
        static float totalPrice;
        Product(){
            totalProducts++;
        }
        Product(string name1,int id,float price1,int quantity1,string category1){
            name=name1;
            ID=id;
            price=price1;
            quantity=quantity1;
            category=category1;
            totalPrice+=price;
            totalProducts+=quantity;
        }    
        void addToInventory(int added_quantity){
            quantity+=added_quantity;
            totalProducts+=quantity;
        }
        void purchase(int purchased_quantity){
            if(availability_status){
                quantity=quantity-purchased_quantity;
            }
        }
        float applyCategoryDiscount(float percent){
            totalPrice-=price;
            price=price-price*percent;
            flag++;
            totalPrice+=price;
            return price;
        }
        float applyProductDiscount(float percent){
            if(flag){
                return 0;
            }
            else{
                 totalPrice-=price;
                 price=price-price*percent;
                 totalPrice+=price;
                 return price;
            }
        }
        int updatePrice(int percent){
            totalPrice-=price;
            price+=price*(percent)/100;
            totalPrice+=price;
            return price;
        }
        float displayInventoryValue()const{
            return quantity*price;
        }
        int getTotalProductsAvailable (){
            return totalProducts;
        }
        ~Product(){
            cout<< "Product Name : "<<name<<endl;
            cout<< "Product ID : "<<ID<<endl;
            cout<< "Product Category :"<<category<<endl;
            cout<< "Product Price :"<<price<<endl;
            if(availability_status) cout<<"Availability : Available"<<endl;
            else cout<<"Availability : Not Available"<<endl;
            cout<< "Total Products :"<<totalProducts<<endl;
            cout<< "Total Price :"<<totalPrice<<endl;
            cout<<endl;
        }
};
int Product::totalProducts=0;
float Product::totalPrice=0;
int main(){
    //Product p[3];
    for(int i=0 ; i<3 ; i++){
        int price,id,q;
        string category_name,name;
        cout <<"Name of the Product :";
        cin>>name;
        cout<<endl;
        cout<<"ID :";
        cin>>id;
        cout<<endl;
        cout<<"Price :";
        cin>>price;
        cout<<endl;
        
        cout<<"Quantity :";
        cin>>q;
        cout<<endl;
        cout<<"Category Name :";
        cin>>category_name;
        cout<<endl;

        Product p(name,id,price,q,category_name);
    }

}