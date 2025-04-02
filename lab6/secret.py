import secrets

# Generate a secure random secret key
secret_key = secrets.token_hex(16)  # 16 bytes -> 32-character hex string
print("Generated Secret Key:", secret_key)
