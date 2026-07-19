package salary_calculator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/SalaryServlet")
public class CalculateSalaryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String empName = request.getParameter("empName");
        String empId = request.getParameter("empId");
        double basicSalary = Double.parseDouble(request.getParameter("basicSalary"));
        
        double hra = basicSalary * 0.20; 
        double da = basicSalary * 0.10;  
        double pf = basicSalary * 0.12;  
        double grossSalary = basicSalary + hra + da;
        
        double tax = 0;
        if (grossSalary > 100000) {
            tax = grossSalary * 0.15;
        } else if (grossSalary > 50000) {
            tax = grossSalary * 0.10;
        }
        
        double netSalary = grossSalary - (pf + tax);
        
        request.setAttribute("empName", empName);
        request.setAttribute("empId", empId);
        request.setAttribute("basicSalary", basicSalary);
        request.setAttribute("hra", hra);
        request.setAttribute("da", da);
        request.setAttribute("pf", pf);
        request.setAttribute("grossSalary", grossSalary);
        request.setAttribute("tax", tax);
        request.setAttribute("netSalary", netSalary);
        
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}