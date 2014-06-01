package communication.protos {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class Dices extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const DICE1:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("communication.protos.Dices.dice1", "dice1", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var dice1:int;

		/**
		 *  @private
		 */
		public static const DICE2:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("communication.protos.Dices.dice2", "dice2", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		public var dice2:int;

		/**
		 *  @private
		 */
		public static const DICE3:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("communication.protos.Dices.dice3", "dice3", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		public var dice3:int;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.dice1);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.dice2);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.dice3);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var dice1$count:uint = 0;
			var dice2$count:uint = 0;
			var dice3$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (dice1$count != 0) {
						throw new flash.errors.IOError('Bad data format: Dices.dice1 cannot be set twice.');
					}
					++dice1$count;
					this.dice1 = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (dice2$count != 0) {
						throw new flash.errors.IOError('Bad data format: Dices.dice2 cannot be set twice.');
					}
					++dice2$count;
					this.dice2 = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if (dice3$count != 0) {
						throw new flash.errors.IOError('Bad data format: Dices.dice3 cannot be set twice.');
					}
					++dice3$count;
					this.dice3 = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
