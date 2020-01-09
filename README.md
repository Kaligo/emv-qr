# EMV QR

An EMV® QR Code encoder written in Ruby.

## Usage

The main entry point is the `#encode` function. It accepts a single hash
argument. See the Input Reference section below for more information on
how to construct this hash.

**Minimal example:**

```ruby
EmvQr.encode(
  merchant: {
    category_code: "1234",
    country_code: "SG",
    name: "7 Eleven",
    city: "Singapore"
  },
  transaction: {
    currency: "SGD",
    amount: 10.00
  }
)
```

## Input Reference

We map the EMV QR format onto a hash that is easier for humans to work
with. Below is a reference for the input hash expected by the encoder.

### Root (required)

| Key                      | Presence  | Size | Format           |
| :---                     | :---      | :--: | ---              |
| `mode`                   | Optional  | -    | String           |
| `merchant`               | Mandatory | -    | Hash (see below) |
| `transaction`            | Mandatory | -    | Hash (see below) |
| `translation`            | Optional  | -    | Hash (see below) |
| `additional`             | Optional  | -    | Hash (see below) |
| `data_request`           | Optional  | -    | Hash (see below) |

### Merchant (required)

| Key                      | Presence  | Size | Format     |
| :---                     | :---      | :--: | ---        |
| `merchant.category_code` | Mandatory | 4    | ISO 18245  |
| `merchant.country_code`  | Mandatory | 2    | ISO 3166-1 |
| `merchant.name`          | Mandatory | 25   | String     |
| `merchant.city`          | Mandatory | 15   | String     |
| `merchant.postal_code`   | Optional  | 10   | String     |

### Transaction (required)

| Key                    | Presence  | Size | Format   |
| :---                   | :---      | :--: | ---      |
| `transaction.currency` | Mandatory | 3    | ISO 4217 |
| `transaction.amount`   | Optional  | -    | Float    |

### Translation (optional)

| Key                         | Presence  | Size | Format    |
| :---                        | :---      | :--: | ---       |
| `translation.language_code` | Mandatory | 2    | ISO 639-1 |
| `translation.merchant_name` | Mandatory | 25   | String    |
| `translation.merchant_city` | Mandatory | 15   | String    |

### Additional (optional)

| Key                          | Presence  | Size | Format    |
| :---                         | :---      | :--: | ---       |
| `additional.bill_number`     | Optional  | 25   | String    |
| `additional.mobile_number`   | Optional  | 25   | String    |
| `additional.store_label`     | Optional  | 25   | String    |
| `additional.loyalty_number`  | Optional  | 25   | String    |
| `additional.reference_label` | Optional  | 25   | String    |
| `additional.terminal_label`  | Optional  | 25   | String    |
| `additional.purpose`         | Optional  | 25   | String    |

### Data Request (optional)

| Key                          | Presence  | Size | Format    |
| :---                         | :---      | :--: | ---       |
| `data_request.address`       | Optional  | -    | Boolean   |
| `data_request.mobile_number` | Optional  | -    | Boolean    |
| `data_request.email_address` | Optional  | -    | Boolean    |

## License

EMV QR is released under the MIT License.
