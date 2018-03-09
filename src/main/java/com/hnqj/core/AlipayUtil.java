package com.hnqj.core;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import com.alipay.api.AlipayClient;
import com.alipay.api.AlipayConstants;
import com.alipay.api.DefaultAlipayClient;

import java.io.*;

/**
	 * 创建时间：2016年11月10日 下午7:09:08
	 *
	 * 支付宝支付参数
	 *
	 * @author andy
	 * @version 2.2
	 */

	public class AlipayUtil {

	public static final String ALIPAY_APPID = "2018010901720041"; // appid
	public static String APP_PRIVATE_KEY = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCZQgq44NelrJLrLX22rsl9zYFOrRYPk4TICVa5hVEyfQjphgbYAuDR4b1Y/tL0+H5m8kI2rFaVjInPnqBvIC7xCYruVeiYojq0lmyYPz3sRiHS8TbWM+adx0wdc1/yjl/KbM/V0etKKMhIK6N1xruzx+Pd3HQsKtKeI04+k3XHxMBOqvqzI8wwKUh1Tkw55r0yItAYLTphtd185L0ZB0OXqvl96i27YVMWL6qHrfAfh4RCb8w27AR7XggoNMzERTdc6MvVBxfLj4aPEkHQ+X2w3yqmhinYLQwJNL03abNABxFxenbhd9qPykiVEdOAR/ova6yp4HMsCLh+FNJjdFjNAgMBAAECggEABj8Bzt0jDNaGul0FRZ/ECIOKpJk7T/E0NS7kQPVlBMjBxzq2JrGfVg58OBdSo7dI94siFbZaZQfwSezuHvlR0HMSHXqU2zupZtjGnkHdlTaahE1ebcZ5vK51tLGSFIGm98oNgmpmy4Pz/bUBmXg7CC26ZL1qYq5wHQ/VTYmXAEg84bwKlBTu1rXgg2dfB7B+969KJ12Z/OFvqUEZQXhBDywSno4JmSyixYm1YR1KJafibAx+FDBJHmcZYcW0neVIXHVfbdBEMRicoFgNLKR8nRimhYiY9CjwtHuV+oxQ4VSon31xhqPrA4ufxPS9deTIx8XdFxopSaRLoOsqei77JQKBgQD+qiq+YQz+dsHzZPvAPsHNhNcRysJLDvwYHwFLkW0yoDnUnZLS0Ed83xFEErklF0V8dSDpecIZvG343gPntnvniRETmF2R1VQ5jdRGC3HPLnhJKl8cenX2/Izu5umkkY3dkN6NjlSNmJUPuTV0gHWcpnXghb+nIhn2SqxaHonHnwKBgQCaD8IM9jik7cMIpiNZj6cHnuUDiPXgCabWdOoCAiNDuSFr7sAxr14VQ6DaKGiMQm6vuj5K2zlRhVB/60v7O2r5+dKODDG3q5Z5rCnOd3MM9LgAbM5ZfVqa/8jT9NhJ8nihy+Z6CqMYHG4fmKALjdbmuwZkP82RHQutelo/NVh4EwKBgDd7T1CmyDPwH5UtXQOnKIXj+Q8xQ18i5p1Cs/+IsWekLLU7ly9CnTCBULup8Jg6F7NjuUXkdvswaC0eAW/L+/aXkBbazRfmiDD5y1NvTt46W45lIs+LhoPGxdWOjTyDUYsB8tqYNaebpG4GhbTZ/8WfJnNB8F0zOsDDyATiPlY1AoGBAIa8aVW0sO1tEzkpM5lMTSQZDuj8iyyYxFSig1WmUPkVm+ktMOFDIeEu+CpTVLv2DZ+aHoiRGZv2H+T//7+Ew5ZDqqWYfJLJehyHOTjctr4J+DJG9mDFhMwyD41vgQmLCX1XOgZZ7zFTC+yOKspwDhZUUs6yDjJvWJsremn1WZ4JAoGBAMed6sW+TlAzQRsEs4kGKSephqDazr2UaHexmIMm/SZ5pZKZyLpDzggNwP4IVFv7OCBbC89ctd6gOSGybPhs4quj20GwqdGMbR0jv/cVQYwVg+v0eDMz/OalQiYA6PhnfCGNGClYPNtK04mTNOVckb51KSTOoi1rCyi8EzEA5H9t"; // app支付私钥
	public static String ALIPAY_PUBLIC_KEY ="MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxkojv38UlylTdWF6d7R+tbLeb1ZW5P3cTxEm9cWJriSGTJsH3MYTi6iXF6DUGhgIHwxtv41i8ixFGCvUcj+JXKEo9Lbwp4cln0QNBO2Ql1Yz6sW28NjxDmNQkdA9So+wsBjOBxtg2/AbPKssWS3ZAfD4hMNWQA41q2Zg0CmWT569Ey56HQN534F8SHIb4IqlNRWoHH9J27SQxPJLtPTBcWXK+gRkMsud1GxD7dPXbu4tUJ20b6zlneFmw0wDtGKLEdY763mJWEJEcHF/RyZh4i4VijdxHMWJrZ3G6meyIVIpoWOxHcdWAm3tO5lI82lUQy7ONYockbfzrXZWdVkkGQIDAQAB";//支付宝公钥
	public static final String url = "https://openapi.alipay.com/gateway.do";

		// 统一收单交易创建接口
		private static AlipayClient alipayClient = null;

		public static AlipayClient getAlipayClient() {
			if (alipayClient == null) {
				synchronized (AlipayUtil.class) {
					if (null == alipayClient) {
						alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do", ALIPAY_APPID,
								APP_PRIVATE_KEY, AlipayConstants.FORMAT_JSON, AlipayConstants.CHARSET_UTF8,
								ALIPAY_PUBLIC_KEY);
					}
				}
			}
			return alipayClient;
		}

    /**
     * 输入流转字符串
     * @param in
     * @return
     */
        public static String InputStream2String(InputStream in) {
            InputStreamReader reader = null;
            try {
                reader = new InputStreamReader(in, "UTF-8");
            } catch (UnsupportedEncodingException e1) {
                e1.printStackTrace();
            }
            BufferedReader br = new BufferedReader(reader);
            StringBuilder sb = new StringBuilder();
            String line = "";
            try {
                while ((line = br.readLine()) != null) {
                    sb.append(line);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            return sb.toString();
        }
	}
