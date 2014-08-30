package communication.protos {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import communication.protos.Card;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class TradeCardsRequest extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const GAMEID:FieldDescriptor$TYPE_INT64 = new FieldDescriptor$TYPE_INT64("communication.protos.TradeCardsRequest.gameId", "gameId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var gameId:Int64;

		/**
		 *  @private
		 */
		public static const CARDID1:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("communication.protos.TradeCardsRequest.cardId1", "cardId1", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return communication.protos.Card; });

		public var cardId1:communication.protos.Card;

		/**
		 *  @private
		 */
		public static const CARDID2:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("communication.protos.TradeCardsRequest.cardId2", "cardId2", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return communication.protos.Card; });

		public var cardId2:communication.protos.Card;

		/**
		 *  @private
		 */
		public static const CARDID3:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("communication.protos.TradeCardsRequest.cardId3", "cardId3", (4 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return communication.protos.Card; });

		public var cardId3:communication.protos.Card;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT64(output, this.gameId);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.cardId1);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.cardId2);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 4);
			com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.cardId3);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var gameId$count:uint = 0;
			var cardId1$count:uint = 0;
			var cardId2$count:uint = 0;
			var cardId3$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (gameId$count != 0) {
						throw new flash.errors.IOError('Bad data format: TradeCardsRequest.gameId cannot be set twice.');
					}
					++gameId$count;
					this.gameId = com.netease.protobuf.ReadUtils.read$TYPE_INT64(input);
					break;
				case 2:
					if (cardId1$count != 0) {
						throw new flash.errors.IOError('Bad data format: TradeCardsRequest.cardId1 cannot be set twice.');
					}
					++cardId1$count;
					this.cardId1 = new communication.protos.Card();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.cardId1);
					break;
				case 3:
					if (cardId2$count != 0) {
						throw new flash.errors.IOError('Bad data format: TradeCardsRequest.cardId2 cannot be set twice.');
					}
					++cardId2$count;
					this.cardId2 = new communication.protos.Card();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.cardId2);
					break;
				case 4:
					if (cardId3$count != 0) {
						throw new flash.errors.IOError('Bad data format: TradeCardsRequest.cardId3 cannot be set twice.');
					}
					++cardId3$count;
					this.cardId3 = new communication.protos.Card();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.cardId3);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
