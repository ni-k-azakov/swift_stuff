//
//  DiscountListView.swift
//  Medilife
//
//  Created by Nikita Kazakov on 08.06.2022.
//

import SwiftUI

struct DiscountListView: View {
    let response: DiscountsInfoResponse
    var body: some View {
        VStack {
            ForEach(response.response) { discount in
                ZStack() {
                    Image(uiImage: UIImage(data: discount.img) ?? UIImage(systemName: "list.bullet.rectangle")!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            alignment: .center
                        )
                        .clipped()
                    VStack {
                        Spacer()
                        Text(discount.header)
                            .padding()
                            .font(.caption)
                            .background(Color.white)
                            .frame(maxWidth: .infinity)
                    }
                    .background(Color.red)
                }
                .background(Color.white)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 20
                    )
                )
                
            }
        }
    }
}

struct DiscountListView_Previews: PreviewProvider {
    static var previews: some View {
        DiscountListView(response: DiscountsInfoResponse(response: [DiscountInfo(id: 0, header: "TEST", info: "TEST", reqularCost: "100", discountCost: "30", section: "TEST", img: UIImage(systemName: "person")!.pngData()!)], discountID: -1, error: false, message: "Not ready yet"))
    }
}
