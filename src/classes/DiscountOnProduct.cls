/**
*  Description     :  Using Interface and calculate the discount for custome,employee and seller 
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  06/29/2022
*
*  Revision Logs   :  V1.0 - Created - Jay Chand Yadav
**/
public virtual class DiscountOnProduct {

    // Purchase Order interface
    public virtual interface PurchaseOrder {

        // All other functionality excluded
        Double discount(Double price);
    }

    // One implementation of the interface for customers
    public class CustomerPurchaseOrder implements PurchaseOrder {

        public Double discount(Double price) {

            return 0.9 * price;                // 10 % discount
        }
    }

    // Another implementation of the interface for employess
    public class EmployeePurchaseOrder implements PurchaseOrder {

        public Double discount(Double price) {
            
            return 0.8 * price;                 // 20 % discount
        }
    }

    // The implementation of the interface for seller
    public class SellerPurchaseOrder implements PurchaseOrder {

        public Double discount(Double price) {

            return 0.7 * price;               // 30 % discount
        }
    }

    public class ProcessPurchaseOrder {

        public ProcessPurchaseOrder() {

            PurchaseOrder order1 = new CustomerPurchaseOrder();
            PurchaseOrder order2 = new EmployeePurchaseOrder();
            PurchaseOrder order3 = new SellerPurchaseOrder();

            // Customer Order
            processOrder(order1, ' after 10 % discount for customer');

            // Employee Order
            processOrder(order2, ' after 20 % discount for employee');

            // Seller Order
            processOrder(order3, ' after 30 % discount for seller');
        }

        public void processOrder(PurchaseOrder order, String str) {

            System.debug('Price ::: ' + order.discount(100) + str);
        }
    }
}