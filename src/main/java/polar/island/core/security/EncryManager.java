package polar.island.core.security;

/*import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;*/
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

public class EncryManager {
	// private RandomNumberGenerator randomNumberGenerator = new
	// SecureRandomNumberGenerator();
	private String algorithmName ;
	private int hashIterations ;

	public EncryManager(String algorithmName, int hashIterations) {
		this.algorithmName = algorithmName;
		this.hashIterations = hashIterations;
	}

	public String encry(String userName, String password, String salt) {
		String newPassword = new SimpleHash(algorithmName, password, ByteSource.Util.bytes(salt), hashIterations)
				.toHex();
		return newPassword;
	}

	public static void main(String[] args) {
		EncryManager e = new EncryManager("sha-1", 1024);
	}

	public String getSalt(String userName) {
		// String salt=randomNumberGenerator.nextBytes().toHex();
		return userName;
	}
}
