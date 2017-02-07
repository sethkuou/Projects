package COEGen;

import java.io.IOException;
import java.io.Reader;
import java.io.FileReader;
import java.io.PrintWriter;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.Map;

public class COEGenerator {

	public static String returnChar() {
		return "," + (char)13 + (char)10;
	}
	
	public static void main(String[] args) throws Exception {
		Reader text = null;
		Reader program = null;
		Reader glyph = null;
		Reader song = null;
		
		try {
			text = new FileReader("text.txt");
			program = new FileReader("program.txt");
			glyph = new FileReader("glyph.coe");
			song = new FileReader("Song.sng");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return;
		}
		
		int outFileX = 0;
		int fileY = 0;
		boolean returnFlag = false;
		boolean EOFFlag = false;
		StringBuilder textOut = new StringBuilder();
		textOut.append("memory_initialization_radix=16;" + (char)13 + (char)10 + "memory_initialization_vector=" + returnChar());
		
		for (int coeCharNum = 0; coeCharNum < 8192; coeCharNum++) {
			if (!(EOFFlag || returnFlag)) {
				int dealWithMe = text.read();
				if (dealWithMe < 0) {
					EOFFlag = true;
					textOut.append("00f8" + returnChar());
				}
				else if (dealWithMe < 16)
					textOut.append("0" + Integer.toHexString(dealWithMe) + "f8" + returnChar());
				else
					textOut.append(Integer.toHexString(dealWithMe) + "f8" + returnChar());
				
				if (dealWithMe == 13) { //Set the return flag, we've found a carriage return
					text.read(); //dispose of 10
					returnFlag = true;
				}
				
				if (outFileX == 79) //Set the return flag, no text past here would display
					returnFlag = true;
				
				
			}
			else
			{
				textOut.append("00f8" + returnChar());
			}
			

			if (++outFileX >= 128) {
				outFileX = 0;
				returnFlag = false;
			}
		}
		
		//skip the first two lines of glyph
		int needTwoReturns = 0;
		while (needTwoReturns < 2)
			if (glyph.read() == 10)
			  needTwoReturns++;
		EOFFlag = false;
		//Now to put in glyphs
		for (int fillAllGlyphs = 0; fillAllGlyphs < 8192; fillAllGlyphs++) {
			String thisLine = "";
			if (EOFFlag)
				thisLine = "0000" + returnChar();
			else
				while (thisLine.length() < 5) {
					int dealWithMe = glyph.read();
					while (dealWithMe == 10 || dealWithMe == 13)
						dealWithMe = glyph.read();
					if (dealWithMe == (int)',' || dealWithMe == (int)' ')
						thisLine = thisLine + returnChar();
					else if (dealWithMe == ';') {
						thisLine = thisLine + returnChar();
						EOFFlag = true;
					}
					else
						thisLine = thisLine + (char)dealWithMe;
				}
			textOut.append(thisLine);
		}
		
		


		
		
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("CUSTOM", Integer.parseInt("7fef", 16));
		StringBuilder label = new StringBuilder();
		int addr = 16384;
		while (true)
		{
			int received;
			if ((received = program.read()) < 0)
				break;
			char captured = (char)received;
			if (captured == 13)
				continue; //ignore 13 characters
			if (captured == 10) {
				//We've finished a line without a colon.
				label.append(captured);
				if (label.charAt(0) == 'J') //Jump, JOE, and JAL
					addr+=2;
				else if (label.charAt(0) == 'P') //Play
					addr+=1;
				else if (label.charAt(0) == 'D') //Done
					addr+=1;
				else if (label.charAt(0) == 'L') { //Load, loadmem
					if (label.toString().contains("MEM"))
							addr+=1;
					else
							addr+=2;
				}
				else if (label.charAt(0) == 'S') { //Shift, Set, Store, Sub
					if (label.charAt(1) == 'H' || label.charAt(1) == 'U')
						addr+=1;
					else
						addr+=2;
				}
				else if (label.charAt(0) == 'I') //Invert
					addr+=1;
				else if (label.charAt(0) == 'A') //Add, And
					addr+=1;
				else if (label.charAt(0) == 'R') //Return
					addr+=1;
				else if (label.charAt(0) == (char)10 || label.charAt(0) == ':')
				{}
				else 
					System.out.println("HEY! What's this instruction? I don't know how many lines it is! " + label);
				label = new StringBuilder();
				continue;
			}
			if (captured == ':') {
				//We've received a full label
				map.put(label.toString(), addr);
				label = new StringBuilder();
			}
			label.append(captured);
		}
		program.close();
		program = new FileReader("program.txt");
		System.out.println("Program is done being read.");
		addr = Integer.parseInt("7000", 16);
		label = new StringBuilder();
		while (true)
		{
			int received;
			if ((received = song.read()) < 0)
				break;
			char captured = (char)received;
			if (captured == 13)
				continue; //ignore 13 characters
			if (captured == 10) {
				addr+=1;
				label = new StringBuilder();
				continue;
			}
			if (captured == ':') {
				//We've received a full label
				song.read();
				song.read();
				map.put(label.toString(), addr);
				label = new StringBuilder();
			}
			label.append(captured);
		}
		
		song.close();
		song = new FileReader("song.sng");
		System.out.println("Song is done being read.");
		
		int linesOfCode = 0;
		//Now actually make the coe
		for (int i = 0; i < 12288; i++) {
			String operation = "";
			int received = program.read();
			while ((received != 10 && received != (int)':' && received > 0)) {
				if (received < 0)
					break;
				if (received == 13) {
					received = program.read();
					continue;
				}
				operation += (char)received;
				received = program.read();
			}
			if (received < 0) {
				textOut.append("ffff" + returnChar());
				continue;
			}
			if (received == (int)':' || operation.equals("")) {
				i--; //This line doesn't count
				continue;
			}
			String toCOE = "";
			if (operation.substring(0, 3).equals("JOE")) {
				toCOE += "00000";
				if (operation.charAt(4) == '#')
					toCOE += "1";
				else
					toCOE += "0";
				String number = "";
				number = Integer.toBinaryString(Integer.parseInt(operation.substring(5,7),10));
				while (number.length() < 5)
					number = "0" + number;
				toCOE += number;
				number = Integer.toBinaryString(Integer.parseInt(operation.substring(9,11),10));
				while (number.length() < 5)
					number = "0" + number;
				toCOE += number;
				String joeInstruction = Integer.toHexString(Integer.parseInt(toCOE, 2));
				while (joeInstruction.length() < 4)
					joeInstruction = "0" + joeInstruction;
				textOut.append(joeInstruction + returnChar());
				i++;
				operation = operation.split("-> ")[1];
				operation = operation.split(";")[0];
				String hex = "";
				hex += "" + Integer.toHexString(map.get(operation));
				while (hex.length() < 4)
					hex = "0" + hex;
				textOut.append(hex + returnChar());
			}
			else if (operation.substring(0, 4).equals("JUMP")) {
				textOut.append("0800" + returnChar());
				i++;
				operation = operation.split("-> ")[1];
				operation = operation.split(";")[0];
				String hex = "";
				hex += "" + Integer.toHexString(map.get(operation));
				while (hex.length() < 4)
					hex = "0" + hex;
				textOut.append(hex + returnChar());
			}
			else if (operation.substring(0, 5).equals("Done."))
				textOut.append("ffff" + returnChar());
			else if (operation.substring(0, 4).equals("PLAY"))
				textOut.append("f3" + operation.substring(5,6) + operation.substring(5,6) + returnChar());
			else if (operation.substring(0, 4).equals("REST"))
				textOut.append("f011" + returnChar());
			else if (operation.substring(0, 5).equals("LOAD ")) {
				String reg = "";
				reg += Integer.toBinaryString(Integer.parseInt(operation.substring(6,8), 10));
				while (reg.length() != 5)
					reg = "0" + reg;
				textOut.append( Integer.toHexString(Integer.parseInt(("00010000000" + reg), 2)) + returnChar());
				i++;
				String jumpTo = operation.split("<- ")[1];
				textOut.append(jumpTo.substring(2, 6) + returnChar());
			}
			else if (operation.substring(0,7).equals("LOADMEM")) {
				String value = Integer.toBinaryString(Integer.parseInt(operation.substring(9,11), 10));
				String register = Integer.toBinaryString(Integer.parseInt(operation.substring(13,15), 10));
				while (register.length() != 5)
					register = "0" + register;
				while (value.length() != 5)
					value = "0" + value;
				String instr = "011010" + value + register;
				textOut.append(Integer.toHexString(Integer.parseInt(instr, 2)) + returnChar());
			}
			else if (operation.substring(0, 5).equals("STORE")) {
				String reg = "";
				reg += Integer.toBinaryString((Integer.parseInt(operation.substring(7,9), 10)));
				while (reg.length() != 5)
					reg = "0" + reg;
				textOut.append(Integer.toHexString(Integer.parseInt(("00011000000" + reg), 2)) + returnChar());
				i++;
				String jumpTo = operation.split("-> ")[1];
				textOut.append(jumpTo.substring(2, 6) + returnChar());
			}
			else if (operation.substring(0,6).equals("SHIFTL")) {
				String shiftNum = Integer.toBinaryString(Integer.parseInt(operation.substring(8,10)));
				while (shiftNum.length() != 5)
					shiftNum = "0" + shiftNum;
				String regNum = Integer.toBinaryString(Integer.parseInt(operation.substring(12,14)));
				while (regNum.length() != 5)
					regNum = "0" + regNum;
				textOut.append(Integer.toHexString(Integer.parseInt(("01000" + "1" + shiftNum + regNum), 2)) + returnChar());
			}
			else if (operation.substring(0,6).equals("SHIFTR")) {
				String shiftNum = Integer.toBinaryString(Integer.parseInt(operation.substring(8,10)));
				while (shiftNum.length() != 5)
					shiftNum = "0" + shiftNum;
				String regNum = Integer.toBinaryString(Integer.parseInt(operation.substring(12,14)));
				while (regNum.length() != 5)
					regNum = "0" + regNum;
				textOut.append(Integer.toHexString(Integer.parseInt(("01000" + "0" + shiftNum + regNum), 2)) + returnChar());
			}
			else if (operation.substring(0,4).equals("SET ")) {
				String register = Integer.toBinaryString(Integer.parseInt(operation.substring(5,7), 10));
				while (register.length() != 5)
					register = "0" + register;
				String binInstr = "00101000000" + register;
				textOut.append(Integer.toHexString(Integer.parseInt(binInstr, 2)) + returnChar());
				i++;
				String toSet = operation.split("<- #")[1];
				toSet = toSet.split(";")[0];
				toSet = Integer.toHexString(Integer.parseInt(toSet, 10));
				while (toSet.length() != 4)
					toSet = "0" + toSet;
				textOut.append(toSet + returnChar());
			}
			else if (operation.substring(0, 6).equals("SETMEM")) {
				String register = Integer.toBinaryString(Integer.parseInt(operation.substring(8,10)));
				while (register.length() != 5)
					register = "0" + register;
				String binInstr = "01011000000" + register;
				textOut.append(Integer.toHexString(Integer.parseInt(binInstr, 2)) + returnChar());
				i++;
				String toSet = operation.split("<- #")[1];
				toSet = toSet.split(";")[0];
				toSet = Integer.toHexString(Integer.parseInt(toSet, 10));
				while (toSet.length() != 4)
					toSet = "0" + toSet;
				textOut.append(toSet + returnChar());
			}
			else if (operation.substring(0,3).equals("AND")) {
				String register = Integer.toBinaryString(Integer.parseInt(operation.substring(9,11), 10));
				String value = Integer.toBinaryString(Integer.parseInt(operation.substring(5,7), 10));
				String literal = "1";
					if (!operation.contains("#"))
						literal = "0";
				while (register.length() != 5)
					register = "0" + register;
				while (value.length() != 5)
					value = "0" + value;
				String instr = "01100" + literal + value + register;
				textOut.append(Integer.toHexString(Integer.parseInt(instr, 2)) + returnChar());
			}
			else if (operation.substring(0,3).equals("ADD")) {
				String register = Integer.toBinaryString(Integer.parseInt(operation.substring(9,11), 10));
				String value = Integer.toBinaryString(Integer.parseInt(operation.substring(5,7), 10));
				String literal = "1";
					if (!operation.contains("#"))
						literal = "0";
				while (register.length() != 5)
					register = "0" + register;
				while (value.length() != 5)
					value = "0" + value;
				String instr = "00110" + literal + value + register;
				textOut.append(Integer.toHexString(Integer.parseInt(instr, 2)) + returnChar());
			}
			else if (operation.substring(0,3).equals("SUB")) {
				String register = Integer.toBinaryString(Integer.parseInt(operation.substring(9,11), 10));
				String value = Integer.toBinaryString(Integer.parseInt(operation.substring(5,7), 10));
				String literal = "1";
					if (!operation.contains("#"))
						literal = "0";
				while (register.length() != 5)
					register = "0" + register;
				while (value.length() != 5)
					value = "0" + value;
				String instr = "00111" + literal + value + register;
				textOut.append(Integer.toHexString(Integer.parseInt(instr, 2)) + returnChar());
			}
			else if (operation.substring(0, 3).equals("JAL")) {
				textOut.append("4800" + returnChar());
				i++;
				operation = operation.split("-> ")[1];
				operation = operation.split(";")[0];
				String hex = "";
				hex += "" + Integer.toHexString(map.get(operation));
				while (hex.length() < 4)
					hex = "0" + hex;
				textOut.append(hex + returnChar());
			}
			else if (operation.substring(0,6).equals("RETURN"))
				textOut.append("5000" + returnChar());
			else if (operation.substring(0, 6).equals("INVERT")) {
				String register = Integer.toBinaryString(Integer.parseInt(operation.substring(8,10), 10));
				while (register.length() != 5)
					register = "0" + register;
				String instruction = "00100000000" + register;
				textOut.append(Integer.toHexString(Integer.parseInt(instruction, 2)) + returnChar());
			}
			else {
				System.out.println("*Invalid instruction: " + operation);
				textOut.append("XXXX" + returnChar());
			}
			linesOfCode++; //If it makes it here, we have a line of code.
			//System.out.println("If there's an error, it's on the line after " + operation);
		}
		System.out.println("\nI found " + linesOfCode + " lines of code.");
		
		
		
		
		
		
		
		
		EOFFlag = false;
		// Insert the song
		for (int noteNum = 0; noteNum < 4096-17; noteNum++) { //the last 16 notes are reserved for the custom song.
			//Each note in the song is represented by 16 binary values, read them in
			if (EOFFlag)
				textOut.append("ffff" + returnChar());
			else {
				String note = "11110";
				int read = song.read();
				
				if (read == (int)'0') {
					textOut.append("ffff" + returnChar());
					song.read();
					song.read();
					continue;
				}

				//skip any labels
				if (read != (int)'1' && read != (int)'2' && read != (int)'4' && read != (int)'8') {
					while ((read = song.read()) != 10) {
						if (read < 0)
							break;
					}
					read = song.read();
				}
				
				//If end of file
				if (read < 0) {
					EOFFlag = true;
					textOut.append("ffff" + returnChar());
					continue;
				}
				
				
				//Get the length
				int length = Integer.parseInt("" + (char)read);
				if (length == 4)
					note += "01";
				else if (length == 8)
					note += "00";
				else if (length == 2)
					note += "10";
				else
					note += "11";
				
				if (song.read() != (int)' ')
					System.out.println("ERROR AT NOTE " + (noteNum+1));
				
				int received;
				String bell = "";
				while((received = song.read()) != 13) {
					if (received < 0)
						break;
					bell += (char)received;
				}
				if (bell.equals("AD"))
					note+="100000000";
				else if (bell.equals("DD"))
					note +="100010001";
				else if (bell.equals("ED"))
					note +="100100010";
				else if (bell.equals("F#D"))
					note +="100110011";
				else if (bell.equals("GD"))
					note +="101000100";
				else if (bell.equals("G#D"))
					note +="101010101";
				else if (bell.equals("A"))
					note +="101100110";
				else if (bell.equals("AU"))
					note +="101110111";
				else if (bell.equals("B"))
					note +="110001000";
				else if (bell.equals("C#"))
					note +="110011001";
				else if (bell.equals("D"))
					note +="110101010";
				else if (bell.equals("D#"))
					note +="110111011";
				else if (bell.equals("E"))
					note +="111001100";
				else if (bell.equals("F#"))
					note +="111011101";
				else if (bell.equals("G"))
					note +="111101110";
				else if (bell.equals("G#"))
					note +="111111111";
				else if (bell.equals("Rest"))
					note +="000000000";
				else {
					note +="000000000";
					System.out.println("I'm not sure what \"" + bell + "\" is.");
				}
				
				int noteHex = Integer.parseInt(note, 2);
				textOut.append(Integer.toHexString(noteHex) + returnChar());
				song.read(); //remove the 10 char
			}
		}
		
		for (int customNote = 0; customNote < 16; customNote++) {
			textOut.append("f000" + returnChar()); //insert a rest
		}
		
		textOut.append("ffff" + returnChar());
		
		
		
		textOut.reverse();
		textOut.replace(0, 3, "   ;");
		textOut.reverse();
		try {
			PrintWriter write = new PrintWriter("setup.coe");
			write.print(textOut.toString());
			write.close();
		} catch (Exception e) {
			System.out.println("There was a problem writing to the coe file");
		}
		

		
		text.close();
		program.close();
		glyph.close();
		song.close();
		System.out.println("done!");
	}

}
