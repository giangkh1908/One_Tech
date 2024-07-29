/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package filter;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author DELL
 */
public class RouterFilter implements Filter {

    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public RouterFilter() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("RouterFilter:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("RouterFilter:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {

        if (debug) {
            log("RouterFilter:doFilter()");
        }

        doBeforeProcessing(request, response);

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String url = httpRequest.getServletPath();
        HttpSession session = httpRequest.getSession();
        Account acc = (Account) session.getAttribute("acc");

        // Set no-cache headers
        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        httpResponse.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        httpResponse.setDateHeader("Expires", 0); // Proxies.

//        System.out.println("Session account: " + (acc != null ? acc.getUsername() : "null"));
//        System.out.println("Requested URL: " + url);

        try {
            if (url.endsWith("home.jsp")) {
                httpResponse.sendRedirect("home");
            }
            if (acc == null && url.contains("CheckoutController")) {
                httpResponse.sendRedirect("home");
            }
//            if (acc == null && url.endsWith("inventory")) {
//                httpResponse.sendRedirect("home");
//            }
            if (acc == null && url.endsWith("HistoryTransaction.jsp")) {
                httpResponse.sendRedirect("home");
                return; // Stop further processing after redirect
            }
             if (acc == null && url.endsWith("cart.jsp")) {
                httpResponse.sendRedirect("home");
                return; // Stop further processing after redirect
            }
            if(acc != null && url.endsWith("cart.jsp")){
                httpResponse.sendRedirect("GetListCartByUserId");
            } 
            if (acc != null) {
                if (url.endsWith("login.jsp")) {
                    httpResponse.sendRedirect("home");
                    return; // Stop further processing after redirect
                }
            } else {
                if (url.contains("ManageAccount") || url.contains("UpdateProfile") || url.endsWith("manage") || url.contains("category")
                        || url.endsWith("ChangePassword.jsp") || url.endsWith("UserProfile.jsp")
                        || url.contains("historytransaction")) {
                    httpResponse.sendRedirect("home");
                    return; // Stop further processing after redirect
                }

            }
            if(url.endsWith("HistoryTransaction.jsp") && acc != null){
                httpResponse.sendRedirect("historytransaction");
            }
            if (acc != null && acc.username.equals("admin")
                    && (url.endsWith("UpdateProfile") || url.endsWith("ChangePassword"))) {
                httpResponse.sendRedirect("home");
                return;
            }
            if (acc != null && !acc.username.equals("admin")
                    && (url.contains("ManageAccount") || url.endsWith("manage") || url.contains("category"))) {
                httpResponse.sendRedirect("home");
                return;
            }

            if (url.endsWith("admindashboard.jsp") && !url.contains("error.jsp")) {
                httpResponse.sendRedirect("home");
                return; // Stop further processing after redirect
            }
            if (url.endsWith("AccountList.jsp") && !url.contains("error.jsp")) {
                httpResponse.sendRedirect("home");
                return; // Stop further processing after redirect
            }
            if (acc == null && url.endsWith("ChangePassword")) {
                httpResponse.sendRedirect("home");
                return; // Stop further processing after redirect
            }
//            if (url.endsWith("ChangePassword.jsp")  && !url.contains("error.jsp")) {
//                httpResponse.sendRedirect("home.jsp");
//                return; // Stop further processing after redirect
//            }

            // Continue the filter chain for other requests
            chain.doFilter(request, response);

        } catch (Throwable t) {
            // Handle exceptions
            handleException(t, request, response);
        } finally {
            doAfterProcessing(request, response);
        }
    }

    private void handleException(Throwable problem, ServletRequest request, ServletResponse response) throws IOException, ServletException {
        if (problem instanceof ServletException) {
            throw (ServletException) problem;
        }
        if (problem instanceof IOException) {
            throw (IOException) problem;
        }
        sendProcessingError(problem, response);
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("RouterFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("RouterFilter()");
        }
        StringBuffer sb = new StringBuffer("RouterFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
