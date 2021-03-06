package com.wing.www;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class Operator {
	private String url;
	private int firstnum;
	private int secondnum;
	private String opera;
	private int result;

	public void setUrl(String str) {
		url = str;
	}

	public void setFirstNum(int num) {
		firstnum = num;
	}

	public void setSecondNum(int num) {
		secondnum = num;
	}

	public void setOpera(String str) {
		opera = str;
	}

	public int getResult() throws IOException {
		String getURL = url + opera + "?firstnum=" + firstnum + "&secondnum="
				+ secondnum;
		URL getUrl = new URL(getURL);
		HttpURLConnection connection = (HttpURLConnection) getUrl
				.openConnection();
		connection.connect();
		BufferedReader reader = new BufferedReader(new InputStreamReader(
				connection.getInputStream()));
		String lines;
		if ((lines = reader.readLine()) != null) {
			result = Integer.parseInt(lines);
		}
		reader.close();
		connection.disconnect();

		return result;
	}
}
