package main

// Runtime: 0 ms, faster than 100.00% of Go online submissions for Reverse Bits.
// Memory Usage: 2.5 MB, less than 99.52% of Go online submissions for Reverse Bits.
func reverseBits(num uint32) uint32 {
	num = (num >> 16) | (num << 16)
	num = ((num & 0xff00ff00) >> 8) | ((num & 0x00ff00ff) << 8)
	num = ((num & 0xf0f0f0f0) >> 4) | ((num & 0x0f0f0f0f) << 4)
	num = ((num & 0xcccccccc) >> 2) | ((num & 0x33333333) << 2)
	num = ((num & 0xaaaaaaaa) >> 1) | ((num & 0x55555555) << 1)
	return num
}
