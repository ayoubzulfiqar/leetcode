package main

func restoreOctets(s string, octetsNumber int8) []string {
	if len(s) == 0 {
		return nil
	}
	if octetsNumber == 1 {
		if (s[0] == '0' && len(s) != 1) || len(s) > 3 || (len(s) == 3 && (s[0] > '2' || (s[0] == '2' && (s[1]-'0')*10+s[2]-'0' > 55))) {
			return nil
		}
		return []string{s}
	}
	var result []string
	if s[0] == '0' {
		for _, s2 := range restoreOctets(s[1:], octetsNumber-1) {
			result = append(result, "0."+s2)
		}
	} else {
		num := 0
		for i := 0; i < len(s); i++ {
			num = num*10 + int(s[i]-'0')
			if num > 255 {
				break
			}
			for _, s2 := range restoreOctets(s[i+1:], octetsNumber-1) {
				result = append(result, s[:i+1]+"."+s2)
			}
		}
	}
	return result
}

func restoreIpAddresses(s string) []string {
	return restoreOctets(s, 4)
}
