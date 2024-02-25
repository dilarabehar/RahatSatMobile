
class ProductRequest {
    String? id;
    String? marketid;
    String? productname;
    String? productbarcode;
    String? message;
    String? createdat;
    String? updatedat;

    ProductRequest({
      this.id, this.marketid, this.productname, this.productbarcode, this.message, this.createdat, this.updatedat
      });

    ProductRequest.fromJson(Map<String, dynamic> json) {
        id = json['id']?.toString();
        marketid = json['market_id']?.toString();
        productname = json['product_name']?.toString();
        productbarcode = json['product_barcode']?.toString();
        message = json['message']?.toString();
        createdat = json['created_at'];
        updatedat = json['updated_at'];
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['id'] = id;
        data['market_id'] = marketid;
        data['product_name'] = productname;
        data['product_barcode'] = productbarcode;
        data['message'] = message;
        data['created_at'] = createdat;
        data['updated_at'] = updatedat;
        return data;
    }
}

class Root {
    List<ProductRequest?>? productRequests;

    Root({this.productRequests});

    Root.fromJson(Map<String, dynamic> json) {
        if (json['productRequests'] != null) {
         productRequests = <ProductRequest>[];
         json['productRequests'].forEach((v) {
         productRequests!.add(ProductRequest.fromJson(v));
        });
      }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['productRequests'] =productRequests != null ? productRequests!.map((v) => v?.toJson()).toList() : null;
        return data;
    }
}

