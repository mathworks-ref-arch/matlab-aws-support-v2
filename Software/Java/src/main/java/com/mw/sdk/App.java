package com.mw.sdk;

import java.lang.reflect.InvocationTargetException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.io.IOException;

/**
 * Java App to leverage Java capabilities in MATLAB.
 * 
 * Copyright 2025 The MathWorks, Inc.
 */
public class App {
    public static void main(String[] args) {
        System.out.println("Hello World!");
    }

    public static String longToString(long x) {
        return String.valueOf(x);
    }

    // No arguments are supported
    public static String invokeNamedMethodToString(Object obj, String methodName) {
        java.lang.reflect.Method method;
        try {
            method = obj.getClass().getMethod(methodName);
            try {
                return String.valueOf(method.invoke(obj));
            } catch (IllegalArgumentException e) {
                System.err.println("Exception: IllegalArgumentException");
            } catch (IllegalAccessException e) {
                System.err.println("Exception: IllegalAccessException");
            } catch (InvocationTargetException e) {
                System.err.println("Exception: InvocationTargetException");
            }
        } catch (SecurityException e) {
            System.err.println("Exception: SecurityException");
        } catch (NoSuchMethodException e) {
            System.err.printf("Exception: NoSuchMethodException: %s\n", methodName);
        }

        System.err.println("Unexpected state, returning \"\"");
        return "";
    }

    public static byte[] convertFileToByteArray(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        return Files.readAllBytes(path);
    }

    public static boolean isOneDriveFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);        
        return Files.exists(path);
    }
}
