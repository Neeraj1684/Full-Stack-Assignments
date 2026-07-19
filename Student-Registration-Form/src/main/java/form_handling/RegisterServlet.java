package form_handling;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String dob = request.getParameter("dob");
		String gender = request.getParameter("gender");
		String course = request.getParameter("course");
		String address = request.getParameter("address");
		
		String[] domains = request.getParameterValues("domains");
		
		request.setAttribute("firstName", firstName);
		request.setAttribute("lastName", lastName);
		request.setAttribute("email", email);
		request.setAttribute("dob", dob);
		request.setAttribute("gender", gender);
		request.setAttribute("course", course);
		request.setAttribute("address", address);
		
		if(domains != null) {
			String joinedDomains = String.join(", ", domains);
			request.setAttribute("domains", joinedDomains);
		}else {
			request.setAttribute("domains", "None Selected");			
		}
		
		request.getRequestDispatcher("success.jsp").forward(request, response);	
	}

}
