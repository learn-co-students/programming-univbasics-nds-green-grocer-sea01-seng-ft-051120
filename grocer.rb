def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  item = nil
  
  i = 0
  while i < collection.length do
    if collection[i][:item] == name
      item = collection[i]
    end
    i += 1
  end
  
  item
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  newCart = []
  
  i = 0
  while i < cart.length do
    
    index = nil
    x = 0
    while x < newCart.length do
      if newCart[x][:item] == cart[i][:item]
        index = x
      end
      x += 1
    end
    
    if index == nil
      cart[i][:count] = 1
      newCart << cart[i]
    else
      newCart[index][:count] += 1
    end
    
    i += 1
  end

  newCart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

  i = 0
  while i < cart.length do
    
    # search for coupons
    coupon = nil
    x = 0
    while x < coupons.length do
      if cart[i][:item] == coupons[x][:item]
        coupon = coupons[x]
      end
      x += 1
    end
    
    # apply coupon
    if coupon != nil
      itemWithCoupon = cart[i].clone
      itemWithCoupon[:item] += " W/COUPON"
      
      numCoupons = (cart[i][:count] / coupon[:num]).floor
      puts numCoupons
      if (numCoupons > 0)
        numForItem = cart[i][:count] - numCoupons * coupon[:num]
      
        cart[i][:count] = numForItem
        itemWithCoupon[:count] = numCoupons * coupon[:num]
        
        itemWithCoupon[:price] = coupon[:cost] / coupon[:num]
        
        cart << itemWithCoupon
      end
      
    end
    
    i += 1
  end

  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  i = 0
  while i < cart.length do
    if (cart[i][:clearance])
      cart[i][:price] *= 0.8
      cart[i][:price] = (cart[i][:price] * 100.0).round / 100.0
    end
    i += 1
  end
  
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  
  i = 0
  total = 0
  while i < cart.length do
    total += cart[i][:price] * cart[i][:count]
    i += 1
  end
  
  if (total > 100.0)
    total *= 0.9
  end
  
  total
end
